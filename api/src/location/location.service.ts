import { Injectable } from '@nestjs/common';
import { CreateLocationDto } from './dto/create-location.dto';
import { UpdateLocationDto } from './dto/update-location.dto';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Location } from './entities/location.entity';

@Injectable()
export class LocationService {
  constructor(
    @InjectRepository(Location)
    private readonly locationRepository: Repository<Location>,
  ) {}

  async create(createlocationDto: CreateLocationDto) {
    const location = this.locationRepository.create(createlocationDto);
    return await this.locationRepository.save(location);
  }

  async findAll() {
    return await this.locationRepository.find();
  }

  async findById(id: string) {
    return await this.locationRepository.findOneBy({ id: id });
  }

  async update(id: string, updatelocationDto: UpdateLocationDto) {
    return await this.locationRepository.update(id, updatelocationDto);
  }

  async remove(id: string) {
    return await this.locationRepository.delete(id);
  }
}
