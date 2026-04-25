import { UserRole } from '../enums/user-role.enum';
import { UserData } from './user-data.interface';

export interface FullUserData extends UserData {
  username: string;
  role: UserRole;
}
