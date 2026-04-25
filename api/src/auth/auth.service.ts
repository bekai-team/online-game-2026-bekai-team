import { Injectable, UnauthorizedException } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { SignUpDto } from './dto/sign-up.dto';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
    private readonly salt: number = 10,
  ) {}

  async signUp(signUpDto: SignUpDto) {
    return await ':D';
  }

  async login(loginDto: LoginDto) {
    const user = await this.userService.findByEmail(loginDto.email);
    const isMatchedPassword = await bcrypt.compare(loginDto.password, user['password']);

    if (!isMatchedPassword) {
      throw new UnauthorizedException('Wrong password');
    }

    const payload = { sub: user['id'], username: user['username'], email: user['email'] };
    return {
      accessToken: await this.jwtService.signAsync(payload),
    };
  }
}
