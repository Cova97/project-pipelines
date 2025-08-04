import { Module } from '@nestjs/common';
import { CategoriesService } from './services/categories.service';
import { CategoriesController } from './controller/categories.controller';
import { BooksModule } from 'src/books/books.module';

@Module({
  providers: [CategoriesService],
  controllers: [CategoriesController],
  imports: [BooksModule]
})
export class CategoriesModule {}
