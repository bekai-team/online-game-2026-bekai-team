import { IsEmail, IsEnum, IsNotEmpty, IsString, IsStrongPassword } from 'class-validator';
import { UserRole } from '../enums/user-role.enum';

export class CreateUserDto {
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
