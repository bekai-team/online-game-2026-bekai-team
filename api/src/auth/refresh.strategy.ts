import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Inject, Injectable } from '@nestjs/common';
import { type ConfigType } from '@nestjs/config';
import { AuthJwtPayload } from './dto/auth-jwt-payload.dto';
import refreshJwtConfig from './config/refresh-jwt.config';

@Injectable()
export class RefreshJwtStrategy extends PassportStrategy(Strategy, 'refresh-jwt') {
  constructor(
    @Inject(refreshJwtConfig.KEY)
    private refreshJwtConfiguration: ConfigType<typeof refreshJwtConfig>,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: refreshJwtConfiguration.secret,
    });
  }

  async validate(payload: AuthJwtPayload) {
    return { userId: payload.sub, email: payload.email };
  }
}
