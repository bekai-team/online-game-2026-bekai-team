import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CreateCharacterDto } from './dto/create-character.dto';
import { UpdateCharacterDto } from './dto/update-character.dto';

@Controller('character')
export class CharacterController {
  constructor(private readonly characterService: CharacterService) {}

  @Post()
  async create(@Body() createCharacterDto: CreateCharacterDto) {
    return await this.characterService.create(createCharacterDto);
  }

  @Get()
  async findAll() {
    return await this.characterService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.characterService.findById(id);
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateCharacterDto: UpdateCharacterDto) {
    return await this.characterService.update(id, updateCharacterDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return await this.characterService.remove(id);
  }
}
