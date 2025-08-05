import { Controller, Get, Post, Body, Param, ParseIntPipe } from '@nestjs/common';
import { BooksService } from '../services/books.service';
import { CreateBookDto } from '../dto/create-book.dto';

@Controller('books')
export class BooksController {
    constructor(private readonly booksService: BooksService) {}

    @Post()
    create(@Body() createBookDto: CreateBookDto) {
        return this.booksService.create(createBookDto);
    }

    @Get()
    findAll() {
        return this.booksService.findAll();
    }

    @Get(':id')
    findOne(@Param('id', ParseIntPipe) id: number) {
        return this.booksService.findOne(id);
    }
}
