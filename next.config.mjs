/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "i.seadn.io",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "ai-backend.dev.blinklabs.ai",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "ai-backend.blinklabs.ai",
        port: "",
        pathname: "/**",
      },
    ],
  },
};

export default nextConfig;
