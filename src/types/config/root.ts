import { z } from 'zod';
import { SystemConfigType } from '@/types/config/system';
import { EncodingOptionsConfigType } from '@/types/config/encoding-options';
import { LibraryConfigType } from '@/types/config/library';
import { BrandingOptionsConfigType } from '@/types/config/branding-options';
import { UserConfigListType } from '@/types/config/users';
import { StartupConfigType } from '@/types/config/startup';
import { PluginConfigListType } from '@/types/config/plugins';

export const RootConfigType: z.ZodObject<{
  version: z.ZodNumber;
  base_url: z.ZodURL;
  system: typeof SystemConfigType;
  encoding: z.ZodOptional<typeof EncodingOptionsConfigType>;
  library: z.ZodOptional<typeof LibraryConfigType>;
  branding: z.ZodOptional<typeof BrandingOptionsConfigType>;
  users: z.ZodOptional<typeof UserConfigListType>;
  plugins: z.ZodOptional<typeof PluginConfigListType>;
  startup: z.ZodOptional<typeof StartupConfigType>;
}> = z
  .object({
    version: z.number().int().positive('Version must be a positive integer'),
    base_url: z.url({ message: 'Base URL must be a valid URL' }),
    system: SystemConfigType,
    encoding: EncodingOptionsConfigType.optional(),
    library: LibraryConfigType.optional(),
    branding: BrandingOptionsConfigType.optional(),
    users: UserConfigListType.optional(),
    plugins: PluginConfigListType.optional(),
    startup: StartupConfigType.optional(),
  })
  .strict();

export type RootConfig = z.infer<typeof RootConfigType>;
