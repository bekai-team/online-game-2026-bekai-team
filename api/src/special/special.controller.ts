import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { SpecialService } from './special.service';
import { CreateSpecialDto } from './dto/create-special.dto';
import { UpdateSpecialDto } from './dto/update-special.dto';

@Controller('special')
export class SpecialController {
  constructor(private readonly specialService: SpecialService) {}

  @Post()
  async create(@Body() createSpecialDto: CreateSpecialDto) {
    return await this.specialService.create(createSpecialDto);
  }

  @Get()
  async findAll() {
    return await this.specialService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.specialService.findById(id);
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateSpecialDto: UpdateSpecialDto) {
    return await this.specialService.update(id, updateSpecialDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return await this.specialService.remove(id);
  }
}
