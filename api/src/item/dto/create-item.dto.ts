import { IsString, MaxLength } from 'class-validator';

export class CreateItemDto {
  @IsString()
  name: string;

  @IsString()
  @MaxLength(500)
  description: string;
}
