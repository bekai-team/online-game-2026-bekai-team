import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { LlmService } from './llm.service';
import { LlmTextDto } from './dto/llm-text.dto';

@Controller('llm')
export class LlmController {
  constructor(private readonly llmService: LlmService) {}

  @Post('chat')
  async chat(@Body() llmTextDto: LlmTextDto) {
    return await this.llmService.chat(llmTextDto);
  }
}
