import { from, Observable } from 'rxjs';
import { z } from 'zod';

export interface DrawingConfig {
    readonly fill: string;
    readonly stroke: string;
    readonly strokeWidth: number;
}

export const defaultDrawingConfig: DrawingConfig = {
    fill: '#ff0000',
    stroke: '#000000',
    strokeWidth: 2
};

const htmlColorInputSchema = z.string().regex(
  /^#[0-9a-fA-F]{6}$/,
  { message: 'Invalid color format. Must be a 7-character hex code (e.g., #RRGGBB).' }
);

export const drawingConfigSchema = z.object({
    fill: htmlColorInputSchema,
    stroke: htmlColorInputSchema,
    strokeWidth: z.number().nonnegative()
});

export function isValidDrawingConfigP(data: unknown): Promise<DrawingConfig> {
    return drawingConfigSchema.parseAsync(data);
}

export function isValidDrawingConfigObs(data: unknown): Observable<DrawingConfig> {
    return from( drawingConfigSchema.parseAsync(data) );
}
