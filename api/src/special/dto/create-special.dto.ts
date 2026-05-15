import { IsNumber, Length } from 'class-validator';

export class CreateSpecialDto {
  @IsNumber()
  @Length(0, 10)
  strength: number;

  @IsNumber()
  @Length(0, 10)
  perception: number;

  @IsNumber()
  @Length(0, 10)
  endurance: number;

  @IsNumber()
  @Length(0, 10)
  charisma: number;

  @IsNumber()
  @Length(0, 10)
  intelligence: number;

  @IsNumber()
  @Length(0, 10)
  agility: number;

  @IsNumber()
  @Length(0, 10)
  luck: number;
}
