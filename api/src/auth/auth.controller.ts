import { Body, Controller, Get, HttpCode, HttpStatus, Post, Req, Request, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { SignUpDto } from './dto/sign-up.dto';
import { LocalAuthGuard } from 'src/guards/local.guard';
import { JwtAuthGuard } from 'src/guards/jwt-auth.guard';
import { ApiBearerAuth, ApiBody } from '@nestjs/swagger';
import { RefreshAuthGuard } from 'src/guards/refresh-auth.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('sign-up')
  async signUp(@Body() signUpDto: SignUpDto) {
    return await this.authService.signUp(signUpDto);
  }

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
    return await this.authService.login(req.user.id, req.user.email);
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

  @ApiBearerAuth()
  @UseGuards(RefreshAuthGuard)
  @Post('refresh')
  async refreshToken(@Req() req) {
    return this.authService.refreshToken(req.user.id, req.user.email);
  }
}
