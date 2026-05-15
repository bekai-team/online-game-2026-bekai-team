import { Injectable } from '@nestjs/common';
import { CreateNpcDto } from './dto/create-npc.dto';
import { UpdateNpcDto } from './dto/update-npc.dto';
import { Npc } from './entities/npc.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class NpcService {
  constructor(
    @InjectRepository(Npc)
    private readonly npcRepository: Repository<Npc>,
  ) {}

  async create(createNpcDto: CreateNpcDto) {
    const npc = this.npcRepository.create(createNpcDto);
    return await this.npcRepository.save(npc);
  }

  async findAll() {
    return await this.npcRepository.find();
  }

  async findOne(id: string) {
    return await this.npcRepository.findOneBy({ id: id });
  }

  async update(id: string, updateNpcDto: UpdateNpcDto) {
    return await this.npcRepository.update(id, updateNpcDto);
  }

  async remove(id: string) {
    return await this.npcRepository.delete(id);
  }
}
