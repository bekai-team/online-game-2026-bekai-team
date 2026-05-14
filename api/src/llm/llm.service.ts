import { Injectable } from '@nestjs/common';
import { LlmTextDto } from './dto/llm-text.dto';
import ollama from 'ollama';

@Injectable()
export class LlmService {
  async chat(llmTextDto: LlmTextDto) {
    const message = { role: llmTextDto.role, content: llmTextDto.text };

    const response = await ollama.chat({
      model: 'tinyllama:1.1b',
      messages: [message],
    });

    return response.message;
  }
}
