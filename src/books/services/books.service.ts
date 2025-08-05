import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateBookDto } from '../dto/create-book.dto';

@Injectable()
export class BooksService {
    constructor(private readonly prisma: PrismaService) {}
    
    async create(createBookDto: CreateBookDto) {
        return this.prisma.book.create({
        data: createBookDto,
        });
    }
    
    async findAll() {
        return this.prisma.book.findMany();
    }
    
    async findOne(id: number) {
        const book = await this.prisma.book.findUnique({
        where: { id },
        });
        if (!book) {
        throw new NotFoundException(`Book with ID ${id} not found`);
        }
        return book;
    }
}
