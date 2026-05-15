import { PartialType } from '@nestjs/swagger';
import { CreateSpecialDto } from './create-special.dto';
import { BaseSpecial } from '../interfaces/base-special.interface';

export class UpdateSpecialDto extends PartialType(CreateSpecialDto) {}
