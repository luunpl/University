import { Point } from "./point";

/**
 * Convert event page coordinates to local coordinates of the given element.
 * @param event The mouse event containing page coordinates.
 * @param element The HTML element to which the coordinates should be relative.
 * @returns A promise that resolves to a Point with local coordinates.
 */
export function eventToLocalPoint(event: MouseEvent, element: HTMLElement): Point {
    const rect = element.getBoundingClientRect();
    const x = event.pageX - rect.left - window.scrollX;
    const y = event.pageY - rect.top  - window.scrollY;
    return { x, y };
}
