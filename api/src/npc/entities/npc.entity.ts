import { NpcAffilation } from 'src/shared/enums/npc-affilation.enum';
import { Column, PrimaryGeneratedColumn } from 'typeorm';

export class Npc {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column({ type: 'text', length: 500 })
  description: string;

  @Column({ type: 'enum', enum: NpcAffilation, default: NpcAffilation.NEUTRAL })
  role: NpcAffilation;
}
