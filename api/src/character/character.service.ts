import { Injectable } from '@nestjs/common';
import { CreateCharacterDto } from './dto/create-character.dto';
import { UpdateCharacterDto } from './dto/update-character.dto';
import { Character } from 'src/character/entities/character.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class CharacterService {
  constructor(
    @InjectRepository(Character)
    private readonly characterRepository: Repository<Character>,
  ) {}

  async create(createCharacterDto: CreateCharacterDto) {
    const character = this.characterRepository.create(createCharacterDto);
    return await this.characterRepository.save(character);
  }

  async findAll() {
    return await this.characterRepository.find();
  }

  async findById(id: string) {
    return await this.characterRepository.findBy({ id: id });
  }

  async update(id: string, updateCharacterDto: UpdateCharacterDto) {
    return await this.characterRepository.update(id, updateCharacterDto);
  }

  async remove(id: string) {
    return await this.characterRepository.delete(id);
  }
}
