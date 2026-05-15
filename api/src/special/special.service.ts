import { Injectable } from '@nestjs/common';
import { CreateSpecialDto } from './dto/create-special.dto';
import { UpdateSpecialDto } from './dto/update-special.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Special } from './entities/special.entity';
import { Repository } from 'typeorm';

@Injectable()
export class SpecialService {
  constructor(
    @InjectRepository(Special)
    private readonly specialRepository: Repository<Special>,
  ) {}

  async create(createSpecialDto: CreateSpecialDto) {
    const special = this.specialRepository.create(createSpecialDto);

    return await this.specialRepository.save(special);
  }

  async findAll() {
    return await this.specialRepository.find();
  }

  async findById(id: string) {
    return await this.specialRepository.findOneBy({ id: id });
  }

  async update(id: string, updateSpecialDto: UpdateSpecialDto) {
    return await this.specialRepository.update(id, updateSpecialDto);
  }

  async remove(id: string) {
    return await this.specialRepository.delete(id);
  }
}
