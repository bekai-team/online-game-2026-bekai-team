import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Special {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'int' })
  strength: number;

  @Column({ type: 'int' })
  perception: number;

  @Column({ type: 'int' })
  endurance: number;

  @Column({ type: 'int' })
  charisma: number;

  @Column({ type: 'int' })
  intelligence: number;

  @Column({ type: 'int' })
  agility: number;

  @Column({ type: 'int' })
  luck: number;
}
