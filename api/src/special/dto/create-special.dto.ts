import { IsNumber, Length } from 'class-validator';
import { BaseSpecial } from '../interfaces/base-special.interface';

export class CreateSpecialDto implements BaseSpecial {
  @IsNumber()
  strength: number;

  @IsNumber()
  perception: number;

  @IsNumber()
  endurance: number;

  @IsNumber()
  charisma: number;

  @IsNumber()
  intelligence: number;

  @IsNumber()
  agility: number;

  @IsNumber()
  luck: number;
}
