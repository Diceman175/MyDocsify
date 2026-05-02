// ============================================================
// Title: Your C# Class
// Purpose: A brief description of what this class does
// ============================================================
//
// METADATA:
//   filename: YourClass.cs
//   title: Your C# Class
//   authorname: Your Name
//   version: 2026-04-21
//   created: 2026-04-20
//   last_updated: 2026-04-21
//
// CHANGELOG:
//   Version 2026-04-21 - Your Name
//     OPS: Include rules-change-codes files and update metadata
//   Version 2026-04-21 - Your Name
//     CHG: Clean 1.0.2 baseline snapshot
//   Most recent entries first. Reference change codes from
//   rules-change-codes.jsonc for semantic versioning.
//
//   Version 0.1.0 - 2026-04-20 - Your Name
//     IMP: Initial C# class setup with metadata template
//
// CHANGE CODES:
//   Reference: rules-change-codes.jsonc
//
//   FIX  - Bug fixes (patch bump)
//   IMP  - New features (minor bump)
//   CHG  - Improvements/refactoring (minor bump)
//   REF  - Documentation/references (patch bump)
//   BRK  - Breaking changes (major bump)
//   SEC  - Security fixes (patch bump)
//   TST  - Tests/CI (patch bump)
//   DOC  - Documentation (patch bump)
//   CFG  - Configuration (minor bump)
//   DEP  - Dependencies (patch bump)
//   OPS  - Operations/deployment (patch bump)
//   WIP  - Work in progress (no version bump)
//
// NOTES:
//   Target framework: .NET 8.0+
//   For full code definitions, see rules-change-codes.jsonc
// ============================================================

using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace YourNamespace
{
    // ============================================================
    // Models
    // ============================================================

    /// <summary>
    /// Represents example data returned by the service.
    /// </summary>
    public sealed record ExampleData(
        int    Id,
        string Key,
        string Value,
        DateTime Timestamp
    );

    // ============================================================
    // Interface
    // ============================================================

    /// <summary>
    /// Defines the contract for the example service.
    /// </summary>
    public interface IExampleService
    {
        Task<ExampleData>  GetAsync(string key);
        Task<bool>         SetAsync(string key, string value);
        IEnumerable<ExampleData> GetAll();
    }

    // ============================================================
    // Implementation
    // ============================================================

    /// <summary>
    /// Example service with basic data retrieval and update operations.
    /// </summary>
    public sealed class ExampleService : IExampleService
    {
        // --------------------------------------------------------
        // Fields
        // --------------------------------------------------------

        private static int _nextId = 1;

        private readonly Dictionary<string, ExampleData> _store
            = new(StringComparer.OrdinalIgnoreCase);

        // --------------------------------------------------------
        // Constructor
        // --------------------------------------------------------

        public ExampleService()
        {
            // Seed with an example record
            var seed = new ExampleData(
                Id:        _nextId++,
                Key:       "example-key",
                Value:     "Example value",
                Timestamp: DateTime.UtcNow
            );
            _store[seed.Key] = seed;
        }

        // --------------------------------------------------------
        // Public Methods
        // --------------------------------------------------------

        /// <inheritdoc />
        public Task<ExampleData> GetAsync(string key)
        {
            ArgumentException.ThrowIfNullOrWhiteSpace(key);

            if (!_store.TryGetValue(key, out var data))
                throw new KeyNotFoundException($"Key '{key}' not found.");

            return Task.FromResult(data);
        }

        /// <inheritdoc />
        public Task<bool> SetAsync(string key, string value)
        {
            ArgumentException.ThrowIfNullOrWhiteSpace(key);
            ArgumentException.ThrowIfNullOrWhiteSpace(value);

            _store[key] = new ExampleData(
                Id:        _store.ContainsKey(key) ? _store[key].Id : _nextId++,
                Key:       key,
                Value:     value,
                Timestamp: DateTime.UtcNow
            );

            return Task.FromResult(true);
        }

        /// <inheritdoc />
        public IEnumerable<ExampleData> GetAll() => _store.Values;
    }

    // ============================================================
    // Entry Point
    // ============================================================

    internal static class Program
    {
        private static async Task Main(string[] args)
        {
            IExampleService service = new ExampleService();

            try
            {
                var result = await service.GetAsync("example-key");
                Console.WriteLine($"[{result.Timestamp:u}] Key={result.Key} Value={result.Value}");

                await service.SetAsync("new-key", "new-value");
                Console.WriteLine("Set 'new-key' successfully.");

                Console.WriteLine("\nAll records:");
                foreach (var item in service.GetAll())
                    Console.WriteLine($"  [{item.Id}] {item.Key} = {item.Value}");
            }
            catch (KeyNotFoundException ex)
            {
                Console.Error.WriteLine($"[error] {ex.Message}");
                Environment.Exit(1);
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"[fatal] {ex}");
                Environment.Exit(1);
            }
        }
    }
}
