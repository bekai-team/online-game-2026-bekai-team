import { Injectable } from '@nestjs/common';

@Injectable()
export class AuthService {
  async signUp() {
    return await ':D';
  }

  async login() {
    return await 'XDD';
  }
}
