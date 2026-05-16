import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Inventory {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  // Add Items here as entity
  // Add relationships with character
  // and NPC
}
