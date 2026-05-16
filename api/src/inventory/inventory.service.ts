import { Injectable } from '@nestjs/common';
import { CreateInventoryDto } from './dto/create-inventory.dto';
import { UpdateInventoryDto } from './dto/update-inventory.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Inventory } from './entities/inventory.entity';
import { Repository } from 'typeorm';

@Injectable()
export class InventoryService {
  constructor(
    @InjectRepository(Inventory)
    private readonly inventoryRepository: Repository<Inventory>,
  ) {}

  async create(createInventoryDto: CreateInventoryDto) {
    const npc = this.inventoryRepository.create(createInventoryDto);
    return await this.inventoryRepository.save(npc);
  }

  async findAll() {
    return await this.inventoryRepository.find();
  }

  async findById(id: string) {
    return await this.inventoryRepository.findOneBy({ id: id });
  }

  async update(id: string, updateInventoryDto: UpdateInventoryDto) {
    return await this.inventoryRepository.update(id, updateInventoryDto);
  }

  async remove(id: string) {
    return await this.inventoryRepository.delete(id);
  }
}
