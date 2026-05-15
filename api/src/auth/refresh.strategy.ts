import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { BadRequestException, HttpException, Inject, Injectable } from '@nestjs/common';
import { type ConfigType } from '@nestjs/config';
import { AuthJwtPayload } from './dto/auth-jwt-payload.dto';
import refreshJwtConfig from './config/refresh-jwt.config';
import { Request } from 'express';
import { AuthService } from './auth.service';

@Injectable()
export class RefreshJwtStrategy extends PassportStrategy(Strategy, 'refresh-jwt') {
  constructor(
    @Inject(refreshJwtConfig.KEY)
    private refreshJwtConfiguration: ConfigType<typeof refreshJwtConfig>,
    private authService: AuthService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: refreshJwtConfiguration.secret,
      passReqToCallback: true,
    });
  }

  async validate(req: Request, payload: AuthJwtPayload) {
    const refreshToken = req.get('authorization')?.replace('Bearer', '').trim();

    if (!refreshToken) {
      throw new BadRequestException('Refresh token is empty');
    }

    const userId = payload.sub;
    const email = payload.email;

    return this.authService.validateRefreshToken(userId, email, refreshToken);
  }
}
