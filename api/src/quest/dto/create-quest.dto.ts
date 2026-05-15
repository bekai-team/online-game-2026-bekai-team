import { IsString } from 'class-validator';

export class CreateQuestDto {
  @IsString()
  name: string;

  @IsString()
  description: string;
}
