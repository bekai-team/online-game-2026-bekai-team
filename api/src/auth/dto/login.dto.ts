import { IsEmail, IsEmpty, IsNotEmpty } from 'class-validator';
import { UserData } from 'src/shared/interface/user-data.interface';

export class LoginDto implements UserData {
  @IsNotEmpty({ message: 'Email field is empty' })
  @IsEmail()
  email: string;

  @IsNotEmpty({ message: 'Password field is empty' })
  password: string;
}
