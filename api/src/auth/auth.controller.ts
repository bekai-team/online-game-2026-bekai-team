import { Body, Controller, Get, HttpCode, HttpStatus, Post, Request, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { SignUpDto } from './dto/sign-up.dto';
import { LocalAuthGuard } from 'src/guards/local.guard';
import { JwtAuthGuard } from 'src/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiBody } from '@nestjs/swagger';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('sign-up')
  async signUp(@Body() signUpDto: SignUpDto) {
    return await this.authService.signUp(signUpDto);
  }

  // @UseGuards(LocalAuthGuard)
  // @Post('login')
  // async login(@Body() loginDto: LoginDto) {
  //   return await this.authService.login(loginDto);
  // }

  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        email: { type: 'string' },
        password: { type: 'string' },
      },
    },
  })
  @UseGuards(LocalAuthGuard)
  @Post('login')
  @HttpCode(HttpStatus.OK)
  async login(@Request() req) {
    const token = await this.authService.login(req.user.id, req.user.email);

    return { ...req.user, accessToken: token };
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Get('profile')
  async getProfile(@Request() req) {
    return req.user;
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Post('logout')
  async logout(@Request() req) {
    return req.logout();
  }

  // @ApiBearerAuth()
  // @Post('refresh')
  // async refresh(@Body() pastRefreshToken: string) {
  //   const { accessToken, refreshToken } = await this.authService.refreshTokens(pastRefreshToken);

  //   if (accessToken) {
  //     throw new UnauthorizedException();
  //   }

  //   return { accessToken, refreshToken };
  // }
}
