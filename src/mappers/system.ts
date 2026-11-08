import {
  type PluginRepositoryConfig,
  type SystemConfig,
  type TrickplayOptionsConfig,
} from '@/types/config/system';
import {
  type PluginRepositorySchema,
  type ServerConfigurationSchema,
  type TrickplayOptionsSchema,
} from '@/types/schema/system';

export function toPluginRepositorySchemas(
  inRepos: PluginRepositoryConfig[],
): PluginRepositorySchema[] {
  return inRepos.map((r: PluginRepositoryConfig): PluginRepositorySchema => {
    return { Name: r.name, Url: r.url, Enabled: r.enabled };
  });
}

export function toTrickplayOptionsSchema(cfg: TrickplayOptionsConfig): TrickplayOptionsSchema {
  const out: TrickplayOptionsSchema = {};
  out.EnableHwAcceleration = cfg.enableHwAcceleration;
  out.EnableHwEncoding = cfg.enableHwEncoding;
  return out;
}

export function mapSystemConfigurationConfigToSchema(
  desired: SystemConfig,
): Partial<ServerConfigurationSchema> {
  const out: Partial<ServerConfigurationSchema> = {};

  if (desired.enableMetrics !== undefined) {
    out.EnableMetrics = desired.enableMetrics;
  }

  if (desired.pluginRepositories !== undefined) {
    out.PluginRepositories = toPluginRepositorySchemas(desired.pluginRepositories);
  }

  if (desired.trickplayOptions !== undefined) {
    out.TrickplayOptions = toTrickplayOptionsSchema(desired.trickplayOptions);
  }

  return out;
}
