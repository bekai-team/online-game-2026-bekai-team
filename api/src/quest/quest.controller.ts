import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { QuestService } from './quest.service';
import { CreateQuestDto } from './dto/create-quest.dto';
import { UpdateQuestDto } from './dto/update-quest.dto';

@Controller('quest')
export class QuestController {
  constructor(private readonly questService: QuestService) {}

  @Post()
  async create(@Body() createQuestDto: CreateQuestDto) {
    return await this.questService.create(createQuestDto);
  }

  @Get()
  async findAll() {
    return await this.questService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return await this.questService.findOne(+id);
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateQuestDto: UpdateQuestDto) {
    return await this.questService.update(+id, updateQuestDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return await this.questService.remove(+id);
  }
}
