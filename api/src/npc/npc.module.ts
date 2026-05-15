import { Module } from '@nestjs/common';
import { NpcService } from './npc.service';
import { NpcController } from './npc.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Npc } from './entities/npc.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Npc])],
  controllers: [NpcController],
  providers: [NpcService],
  exports: [TypeOrmModule],
})
export class NpcModule {}
