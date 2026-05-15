import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateSpecialDto } from './dto/create-special.dto';
import { UpdateSpecialDto } from './dto/update-special.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Special } from './entities/special.entity';
import { Repository } from 'typeorm';
import { BaseSpecial } from './interfaces/base-special.interface';

@Injectable()
export class SpecialService {
  private readonly totalPoints: number = 40;
  constructor(
    @InjectRepository(Special)
    private readonly specialRepository: Repository<Special>,
  ) {}

  private calculateTotalSpecialPoints(specialDto: any) {
    return (
      specialDto.strength +
      specialDto.perception +
      specialDto.endurance +
      specialDto.charisma +
      specialDto.intelligence +
      specialDto.agility +
      specialDto.luck
    );
  }

  async create(createSpecialDto: CreateSpecialDto) {
    const calculatedPoints = this.calculateTotalSpecialPoints(createSpecialDto);

    if (calculatedPoints > this.totalPoints) {
      throw new BadRequestException('Total points should not be bigger than 35');
    }

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
