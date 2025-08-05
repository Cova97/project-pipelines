import { IsString, IsNotEmpty, IsDateString, IsISBN, IsArray, IsInt } from 'class-validator';

export class CreateBookDto {
  @IsString()
  @IsNotEmpty()
  title: string;

  @IsString()
  @IsNotEmpty()
  author: string;

  @IsDateString()
  published: string; // Se recibe como string en formato ISO 8601 y se convierte

  @IsISBN()
  isbn: string;
  
  // Para recibir un array de IDs de categorías
  @IsArray()
  @IsInt({ each: true })
  categoryIds: number[];
}