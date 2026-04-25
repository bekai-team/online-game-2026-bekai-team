import { IsEmail, IsEnum, IsNotEmpty, IsString, IsStrongPassword } from 'class-validator';
import { UserRole } from 'src/shared/enums/user-role.enum';
import { UserDataSignUp } from 'src/shared/interface/user-data-signup.interface';

export class SignUpDto implements UserDataSignUp {
  @IsNotEmpty({ message: 'Username field is empty' })
  @IsString()
  username: string;

  @IsNotEmpty({ message: 'Email field is empty' })
  @IsEmail()
  email: string;

  @IsNotEmpty({ message: 'Password field is empty' })
  @IsStrongPassword({
    minLength: 8,
    minLowercase: 1,
    minUppercase: 1,
    minNumbers: 1,
    minSymbols: 1,
  })
  password: string;

  @IsEnum(UserRole)
  role: UserRole;
}
