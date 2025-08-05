import { forwardRef, Module } from '@nestjs/common';
import { BooksService } from './services/books.service';
import { BooksController } from './controller/books.controller';
import { CategoriesModule } from 'src/categories/categories.module';
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  providers: [BooksService],
  controllers: [BooksController],
  imports: [PrismaModule,
    forwardRef(() => CategoriesModule)
  ]
})
export class BooksModule {}
