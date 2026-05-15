import { Injectable } from '@nestjs/common';
import { CreateQuestDto } from './dto/create-quest.dto';
import { UpdateQuestDto } from './dto/update-quest.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Quest } from './entities/quest.entity';

@Injectable()
export class QuestService {
  constructor(
    @InjectRepository(Quest)
    private questRepository: Repository<Quest>,
  ) {}

  async create(createQuestDto: CreateQuestDto) {
    const quest = this.questRepository.create(createQuestDto);
    return await this.questRepository.save(quest);
  }

  async findAll() {
    return await this.questRepository.find();
  }

  async findById(id: string) {
    return await this.questRepository.findBy({ id: id });
  }

  async update(id: string, updateQuestDto: UpdateQuestDto) {
    return await this.questRepository.update(id, updateQuestDto);
  }

  async remove(id: string) {
    return await this.questRepository.delete(id);
  }
}
