import { BadRequestException, Inject, Injectable, Res, UnauthorizedException } from '@nestjs/common';
import { SignUpDto } from './dto/sign-up.dto';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import { AuthJwtPayload } from './dto/auth-jwt-payload.dto';
import refreshJwtConfig from './config/refresh-jwt.config';
import { type ConfigType } from '@nestjs/config';
import * as argon2 from 'argon2';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
    @Inject(refreshJwtConfig.KEY)
    private refreshTokenConfig: ConfigType<typeof refreshJwtConfig>,
  ) {}

  async signUp(signUpDto: SignUpDto) {
    const existedUserByEmail = await this.userService.findByEmail(signUpDto.email);

    if (existedUserByEmail?.email) {
      throw new BadRequestException('User with such email exists!');
    }

    if (existedUserByEmail?.username) {
      throw new BadRequestException('User with such username exists!');
    }

    const user = await this.userService.create(signUpDto);

    return {
      message: 'User has been created successfuly!',
    };
  }

  async login(userId: string, email: string) {
    const { accessToken, refreshToken } = await this.generateTokens(userId, email);
    const hashedRefreshToken = await argon2.hash(refreshToken);

    await this.userService.updateHashedRefreshToken(userId, hashedRefreshToken);

    const result = {
      id: userId,
      email: email,
      accessToken,
      refreshToken,
    };
    return result;
  }

  async generateTokens(userId: string, email: string) {
    const payload: AuthJwtPayload = { sub: userId, email: email };

    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(payload),
      this.jwtService.signAsync(payload, this.refreshTokenConfig),
    ]);

    return {
      accessToken,
      refreshToken,
    };
  }

  async validateUser(email: string, password: string) {
    const user = await this.userService.findByEmail(email);

    if (!user) {
      throw new UnauthorizedException('User not found');
    }

    const isMatchedPassword = await bcrypt.compare(password, user.password);

    if (!isMatchedPassword) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const result = {
      id: user.id,
      email: user.email,
    };
    return result;
  }

  async refreshToken(userId: string, email: string) {
    const { accessToken, refreshToken } = await this.generateTokens(userId, email);
    const hashedRefreshToken = await argon2.hash(refreshToken);

    await this.userService.updateHashedRefreshToken(userId, hashedRefreshToken);

    const result = {
      id: userId,
      email: email,
      accessToken,
      refreshToken,
    };

    return result;
  }

  async validateRefreshToken(userId: string, email: string, refreshToken: string) {
    const user = await this.userService.findById(userId);
    if (!user || !user.hashedRefreshToken) {
      throw new UnauthorizedException('Invalid Refresh Token');
    }

    const refreshTokenMatches = await argon2.verify(user.hashedRefreshToken, refreshToken);

    if (!refreshTokenMatches) {
      throw new UnauthorizedException('Invalid Refresh Token');
    }

    const result = {
      id: userId,
      email: email,
    };

    return result;
  }

  async logout(userId: string) {
    await this.userService.updateHashedRefreshToken(userId, null);
  }
}
