import { logger } from '@/lib/logger';
import { describe, expect, it, vi, type Mock } from 'vitest';

describe('lib/logger', () => {
  it('whenInfoCalled_thenWritesToConsoleLog()', () => {
    // Arrange
    const spy: Mock = vi.spyOn(console, 'log').mockImplementation(() => undefined);

    // Act
    logger.info('hello');

    // Assert
    expect(spy).toHaveBeenCalledWith('hello');

    spy.mockRestore();
  });

  it('whenWarnCalled_thenWritesToConsoleWarn()', () => {
    // Arrange
    const spy: Mock = vi.spyOn(console, 'warn').mockImplementation(() => undefined);

    // Act
    logger.warn('w');

    // Assert
    expect(spy).toHaveBeenCalledWith('w');

    spy.mockRestore();
  });

  it('whenErrorCalled_thenWritesToConsoleError()', () => {
    // Arrange
    const spy: Mock = vi.spyOn(console, 'error').mockImplementation(() => undefined);

    // Act
    logger.error('e');

    // Assert
    expect(spy).toHaveBeenCalledWith('e');

    spy.mockRestore();
  });
});
