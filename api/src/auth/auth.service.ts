import { BadRequestException, Inject, Injectable, Res, UnauthorizedException } from '@nestjs/common';
import { SignUpDto } from './dto/sign-up.dto';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { AuthJwtPayload } from './dto/auth-jwt-payload.dto';
import refreshJwtConfig from './config/refresh-jwt.config';
import { type ConfigType } from '@nestjs/config';
import { Response } from 'express';

@Injectable()
export class AuthService {
  private readonly salt: number = 10;

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

  async login(userId: string, email: string, res: Response) {
    const payload: AuthJwtPayload = { sub: userId, email: email };
    const token = await this.jwtService.signAsync(payload);
    const refreshToken = await this.jwtService.signAsync(payload, this.refreshTokenConfig);

    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: false, // Change on "true" on prod
      sameSite: 'strict',
      maxAge: 7 * 24 * 60 * 60 * 1000,
    });

    const result = {
      id: userId,
      email: email,
      token,
    };
    return result;
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
    const payload: AuthJwtPayload = { sub: userId, email: email };
    const token = await this.jwtService.signAsync(payload);

    return {
      id: userId,
      email: email,
      token,
    };
  }
}
