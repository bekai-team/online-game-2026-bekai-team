import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';
import { UserRole } from '../../shared/enums/user-role.enum';

@Entity()
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ length: 50, unique: true })
  username: string;

  @Column({ length: 200, unique: true })
  email: string;

  @Column({ length: 100 })
  password: string;

  @Column({ type: 'enum', enum: UserRole, default: UserRole.USER })
  role: UserRole;
}
