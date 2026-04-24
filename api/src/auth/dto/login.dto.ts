import { IsEmail, IsNotEmpty } from 'class-validator';

export class LoginDto {
  @IsNotEmpty({ message: 'Email field is empty' })
  @IsEmail()
  email: string;

  @IsNotEmpty({ message: 'Password field is empty' })
  password: string;
}
