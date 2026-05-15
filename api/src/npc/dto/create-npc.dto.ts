import { Transform } from 'class-transformer';
import { IsEnum, IsString, MaxLength } from 'class-validator';
import { NpcAffilation } from 'src/shared/enums/npc-affilation.enum';

export class CreateNpcDto {
  @IsString()
  name: string;

  @IsString()
  @MaxLength(500)
  description: string;

  @Transform(({ value }) => (typeof value === 'string' ? value.toLowerCase() : value))
  @IsEnum(NpcAffilation)
  affilation: NpcAffilation;
}
