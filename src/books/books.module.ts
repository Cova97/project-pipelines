import { Module } from '@nestjs/common';
import { BooksService } from './services/books.service';
import { BooksController } from './controller/books.controller';
import { CategoriesModule } from 'src/categories/categories.module';

@Module({
  providers: [BooksService],
  controllers: [BooksController],
  imports: [CategoriesModule]
})
export class BooksModule {}
