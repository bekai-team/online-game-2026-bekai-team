import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';
import { UserRole } from '../enums/user-role.enum';

@Entity()
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ length: 50 })
  username: string;

  @Column({ length: 200 })
  email: string;

  @Column({ length: 100 })
  password: string;

  @Column({ type: 'enum', enum: UserRole, default: UserRole.USER })
  role: UserRole;
}
