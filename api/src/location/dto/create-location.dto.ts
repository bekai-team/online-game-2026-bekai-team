import { IsString, MaxLength } from 'class-validator';

export class CreateLocationDto {
  @IsString()
  name: string;

  @IsString()
  @MaxLength(500)
  description: string;
}
