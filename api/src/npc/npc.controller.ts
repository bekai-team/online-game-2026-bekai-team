import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { NpcService } from './npc.service';
import { CreateNpcDto } from './dto/create-npc.dto';
import { UpdateNpcDto } from './dto/update-npc.dto';

@Controller('npc')
export class NpcController {
  constructor(private readonly npcService: NpcService) {}

  @Post()
  async create(@Body() createNpcDto: CreateNpcDto) {
    return await this.npcService.create(createNpcDto);
  }

  @Get()
  async findAll() {
    return await this.npcService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return await this.npcService.findOne(id);
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateNpcDto: UpdateNpcDto) {
    return await this.npcService.update(id, updateNpcDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return await this.npcService.remove(id);
  }
}
