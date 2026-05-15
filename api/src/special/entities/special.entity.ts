import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Special {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'int', length: 10 })
  strength: number;

  @Column({ type: 'int', length: 10 })
  perception: number;

  @Column({ type: 'int', length: 10 })
  endurance: number;

  @Column({ type: 'int', length: 10 })
  charisma: number;

  @Column({ type: 'int', length: 10 })
  intelligence: number;

  @Column({ type: 'int', length: 10 })
  agility: number;

  @Column({ type: 'int', length: 10 })
  luck: number;
}
