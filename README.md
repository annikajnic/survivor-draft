# Survivor Draft

A web application for managing and participating in Survivor TV show draft pools. This app allows users to make predictions about contestants' performance and track their success throughout the season.

## Features

- **User Management**
  - User registration and authentication
  - Admin and regular user roles
  - User profiles with first and last names

- **Contestant Management**
  - Admin can add, edit, and manage contestants
  - Track contestant status (active/inactive)
  - Organize contestants by season and tribe
  - Filter and search contestants

- **Episode Voting**
  - Users can vote for contestants each episode
  - Track voting history
  - View current episode's votes
  - Voting deadlines and restrictions

- **Final Predictions**
  - Users can make final predictions
  - Track prediction accuracy
  - View other users' predictions

- **Admin Dashboard**
  - Manage contestants, episodes, and users
  - View statistics and analytics
  - Control voting periods and deadlines

## Prerequisites

- Ruby 3.2.2 or higher
- Rails 8.0.2 or higher
- PostgreSQL
- Node.js and Yarn (for asset management)

## Local Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd survivor-draft
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Create an admin user**
   ```bash
   rails console
   User.create!(
     email: 'admin@example.com',
     password: 'password',
     first_name: 'Admin',
     last_name: 'User',
     admin: true
   )
   ```

5. **Start the server**
   ```bash
   rails server
   ```

6. **Access the application**
   - Visit `http://localhost:4000`
   - Sign in with your admin credentials

## Usage

### For Admins

1. **Access the admin dashboard**
   - Sign in with admin credentials
   - Navigate to `/admin/dashboard`

2. **Manage Contestants**
   - Add new contestants with their season and tribe information
   - Update contestant status as the season progresses
   - Filter and search contestants by season or tribe

3. **Manage Episodes**
   - Create new episodes
   - Set voting deadlines
   - Track episode progress

4. **Manage Users**
   - View all users
   - Update user information
   - Monitor user activity

### For Regular Users

1. **Participate in Voting**
   - Vote for contestants each episode
   - View your voting history
   - See other users' votes

2. **Make Predictions**
   - Submit final predictions
   - Track your prediction accuracy
   - Compare with other users

3. **View Statistics**
   - Check your performance
   - View leaderboards
   - Track contestant progress

## Development

### Running Tests
```bash
rails test
```

### Code Style
The project uses RuboCop for code style enforcement:
```bash
bundle exec rubocop
```

### Security
The application uses Devise for authentication and includes:
- Password encryption
- Session management
- Role-based access control

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
