import { makeClient } from '@/api/client';
import { type paths } from '@generated/schema';
import { version } from '@root/package.json';
import type { Client } from 'openapi-fetch';
import { describe, expect, it, vi, type Mock } from 'vitest';

describe('api/client', () => {
  it('whenClientCreated_thenHeadersInjectedOnEachRequest()', async () => {
    // Arrange
    const spy: Mock = vi
      .spyOn(globalThis as unknown as { fetch: typeof fetch }, 'fetch')
      .mockResolvedValue(new Response(JSON.stringify({ ok: true }), { status: 200 }));

    try {
      // Act
      const jf: Client<paths> = makeClient('http://example:8096', 'XYZ');

      await jf.GET('/System/Info/Public');

      // Assert
      expect(spy).toHaveBeenCalledTimes(1);

      const req: Request = spy.mock.calls[0]?.[0] as Request;
      expect(req).toBeInstanceOf(Request);

      const h: Headers = req.headers;
      expect(h.get('Authorization')).toBe(
        `MediaBrowser Token="XYZ", Client="jellarr", Device="cli", DeviceId="jellarr", Version="${version}"`,
      );
      expect(h.get('X-Emby-Token')).toBeNull();
      expect(h.get('X-Emby-Authorization')).toBeNull();
    } finally {
      spy.mockRestore();
    }
  });
});
