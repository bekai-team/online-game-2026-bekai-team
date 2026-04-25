import { HttpException, Injectable, UnauthorizedException } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { SignUpDto } from './dto/sign-up.dto';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { UserData } from 'src/shared/interface/user-data.interface';

@Injectable()
export class AuthService {
  private readonly salt: number = 10;

  constructor(
    private userService: UserService,
    private jwtService: JwtService,
  ) {}

  async signUp(signUpDto: SignUpDto) {
    const existedUserByEmail = await this.userService.findByEmail(signUpDto.email);

    console.log(existedUserByEmail);

    if (existedUserByEmail['email']) {
      throw new HttpException('User with such email exists!', 400);
    }

    if (existedUserByEmail['username']) {
      throw new HttpException('User with such username exists!', 400);
    }

    const user = await this.userService.create(signUpDto);

    return {
      message: 'User has been created successfuly!',
    };
  }

  async login(loginDto: LoginDto) {
    const user = await this.userService.findByEmail(loginDto.email);

    if (!user['email']) {
      throw new UnauthorizedException('Email does not exist!');
    }

    const isMatchedPassword = await bcrypt.compare(loginDto.password, user['password']);

    if (!isMatchedPassword) {
      throw new UnauthorizedException('Wrong password!');
    }

    const payload = { sub: user['id'], username: user['username'], email: user['email'] };
    return {
      accessToken: await this.jwtService.signAsync(payload),
    };
  }
}
