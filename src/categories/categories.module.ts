import { forwardRef, Module } from '@nestjs/common';
import { CategoriesService } from './services/categories.service';
import { CategoriesController } from './controller/categories.controller';
import { BooksModule } from 'src/books/books.module';
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  providers: [CategoriesService],
  controllers: [CategoriesController],
  imports: [PrismaModule,
    forwardRef(() => BooksModule)
  ]
})
export class CategoriesModule {}
